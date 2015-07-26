<?php
class Ulyaoth_GlobalTemplateVariable_Listener
{
    public static function template_create(&$templateName, array &$ulyaoth, XenForo_Template_Abstract $template)
    {
        $ulyaoth['sjir'] = "Hello";
    }
}