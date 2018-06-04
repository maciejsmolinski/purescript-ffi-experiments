module Html where

import Prelude

import Data.Array (foldMap, null)

type ElementProperties = { tagName :: String
                         , children :: Array Element
                         }
type TextContentProperties = String

data Element = Element ElementProperties | TextContent TextContentProperties

instance showElement :: Show Element where
    show (Element { tagName, children }) | null children = "<" <> tagName <> ">" <> "</" <> tagName <> ">"
                                         | otherwise = "<" <> tagName <> ">" <> foldMap show children <> "</" <> tagName <> ">"
    show (TextContent text) = text

element :: String -> Array Element -> Element
element tagName children = Element { tagName, children }

html :: Array Element -> Element
html children = element "html" children

html_ :: Element
html_ = element "html" []

body :: Array Element -> Element
body children = element "body" children

body_ :: Element
body_ = element "body" []

text_ :: String -> Element
text_ = TextContent

render :: String -> Element
render text = html [ body [ text_ text ] ]

template :: Element
template = render "Hello World!"

template' :: Element
template' = render "Hello World!!"