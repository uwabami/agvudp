#! /usr/bin/python
import sys
from concurrent.futures import ProcessPoolExecutor, as_completed
import bizud
import agave
import emoji
import agvudp
import font_patcher

BIZUD = [
    ["sourceFonts/BIZUDGothic-Regular.ttf"],
    ["sourceFonts/BIZUDGothic-Bold.ttf"],
]
AGV = [
    ["sourceFonts/Agave-Regular.ttf"],
    ["sourceFonts/Agave-Bold.ttf"],
]
EMOJI = [
    ["sourceFonts/TwitterColorEmoji-SVGinOT-ThickFallback.ttf"]
]
AGVUD = [
    ["tmp/modified-Agave-Regular.ttf",
     "tmp/modified-BIZUDGothic-Regular.ttf",
     "tmp/modified-TwitterColorEmoji-SVGinOT-ThickFallback.ttf"],
    ["tmp/modified-Agave-Bold.ttf",
     "tmp/modified-BIZUDGothic-Bold.ttf",
     "tmp/modified-TwitterColorEmoji-SVGinOT-ThickFallback.ttf"],
]
AGVUDP = [
    ["tmp/AGVUDP-Regular.ttf", "dists"],
    ["tmp/AGVUDP-Bold.ttf", "dists"],
]

def build(version):
    # print("---- modifying BIZ UDGothic ----")
    # if concurrent_execute(bizud.modify, BIZUD):
    #     return 1
    # print("---- modifying Agave ----")
    # if concurrent_execute(agave.modify, AGV):
    #     return 1
    # print("---- modifying Twitter Color Emoji ----")
    # if concurrent_execute(emoji.modify, EMOJI):
    #     return 1
    # print("---- generate AGVUDP  ----")
    # args = [a + [version] for a in AGVUD]
    # if concurrent_execute(agvudp.generate, args):
    #     return 1
    print("---- adding Icons ----")
    if concurrent_execute(font_patcher.patch, AGVUDP):
        return 1
    return 0

def concurrent_execute(func, args):
    executor = ProcessPoolExecutor()
    futures = [executor.submit(func, *a) for a in args]
    return 1 if any([r.result() for r in as_completed(futures)]) else 0
