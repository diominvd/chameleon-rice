#!/usr/bin/env python3
import os
import subprocess
from typing import List, Callable, Union, Optional, Any

class Node:
    def __init__(self, name: str, icon: str = "", color: Optional[str] = None, weight: str = "normal"):
        self.name = name
        self.icon = icon
        self.color = color
        self.weight = weight

    def render(self) -> str:
        if not self.icon:
            return self.name

        is_path = self.icon.startswith("/") or self.icon.startswith("~")
        if is_path and os.path.exists(os.path.expanduser(self.icon)):
            return self.name  # Скрываем путь, возвращаем только имя

        return f"{self.icon}  {self.name}"

class Action(Node):
    def __init__(self, name: str, command: Any, icon: str = "", color: Optional[str] = None, weight: str = "normal", exit: bool = False):
        super().__init__(name, icon, color, weight)
        self.command = command
        self.exit = exit

    def execute(self) -> bool:
        if callable(self.command):
            self.command()
        else:
            subprocess.Popen(str(self.command), shell=True)
        return self.exit

class Parent(Node):
    def __init__(
        self,
        name: str,
        icon: str = "",
        children: Optional[Union[List[Any], Callable[[], List[Any]]]] = None,
        color: Optional[str] = None,
        weight: str = "normal",
        search: bool = False
    ):
        super().__init__(name, icon, color, weight)
        self._children: Union[List[Any], Callable[[], List[Any]]] = children or []
        self.search = search

    def get_children(self) -> List[Any]:
        if callable(self._children):
            return self._children()
        return self._children

class Toggle(Node):
    def __init__(self, name: str, states: List[str], get_state: Callable[[], str], set_state: Callable[[str], None], icon: str = ""):
        super().__init__(name, icon)
        self.states = states
        self.get_state = get_state
        self.set_state = set_state

    def render(self) -> str:
        current = self.get_state()
        if self.icon and not (self.icon.startswith("/") or self.icon.startswith("~")):
            base = f"{self.icon}  {self.name}"
        else:
            base = self.name
        return f"{base}: <span weight='bold' foreground='#5c5c5c'>{current}</span>"

    def toggle(self):
        current = self.get_state()
        new_state = self.states[(self.states.index(current) + 1) % len(self.states)]
        self.set_state(new_state)
