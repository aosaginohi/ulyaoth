<?php
class Ulyaoth_GlobalTemplateVariable_Listener
{

public static function template_create(&$templateName, array &$params, XenForo_Template_Abstract $template)
{
  $db = XenForo_Application::get('db');
  $latestThreads = $db->fetchAll("SELECT * FROM xf_thread AS thread
                                  JOIN xf_post AS post
                                      ON thread.first_post_id = post.post_id
                                  ORDER BY thread.post_date DESC
                                  LIMIT 30");
  $params['latestThreads'] = $latestThreads;
}

}