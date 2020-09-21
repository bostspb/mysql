/**
 * Курсовой проект "БД для онлайн-сервиса Кредитная витрина"
 * ---------------------------------------------------------
 * Факультет: Geek University Data Engineering
 * Курс: Базы данных
 * ---------------------------------------------------------
 * Спроектированния БД предназначена для мультисайтовой CMS, управляющей кредитными витринами.
 * Витрина представляет собой таблицу с набором офферов (кредитных предложений) с реферальными ссылками.
 * Набор офферов на витрине варьируется в зависимости от тематики страницы (тип кредита, тег и т.п.) и региона (один сайт - один город).
 * Порядок расположения офферов на витрине зависит от EPC оффера, т.е. его доходности.
 * Помимо страниц с витринами, каждый сайт имеет служебные страницы, блог и справочник банков города.
 */

-- 
-- Содержание
-- 
-- 1. 
-- 2.
--


--
-- 1. Table мммммм
--

DROP TABLE IF EXISTS `debit_cards_tags`;
CREATE TABLE `debit_cards_tags` (
  `debit_card_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`debit_card_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  `date` int(10) unsigned NOT NULL,
  `category` varchar(64) NOT NULL,
  `category_link` varchar(128) NOT NULL DEFAULT 'finances',
  `rss_url` varchar(128) NOT NULL,
  `rss_name` varchar(128) NOT NULL,
  `main_content` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rss_url` (`rss_url`),
  KEY `category_link` (`category_link`)
) ENGINE=InnoDB AUTO_INCREMENT=70809 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `host` varchar(128) NOT NULL,
  `link` varchar(128) NOT NULL,
  `title` varchar(1024) NOT NULL,
  `h1` varchar(1024) NOT NULL,
  `meta_description` varchar(1024) NOT NULL,
  `image` varchar(128) NOT NULL,
  `anons` text NOT NULL,
  `main_content` text NOT NULL,
  `offers_header` varchar(128) NOT NULL,
  `calculator_header` varchar(128) NOT NULL,
  `banks_header` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL,
  `tag` varchar(128) NOT NULL,
  `tag_group` varchar(128) NOT NULL,
  `tag_order` int(6) unsigned NOT NULL,
  `filter_tags` varchar(255) NOT NULL DEFAULT '',
  `tag_rules` varchar(255) NOT NULL DEFAULT '',
  `tag_parent` varchar(128) NOT NULL DEFAULT '',
  `tag_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_IDX` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1191 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `offers_history`;
CREATE TABLE `offers_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offer_id` smallint(5) unsigned NOT NULL,
  `calc_date` date NOT NULL,
  `epc` int(11) NOT NULL,
  `mct` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `offer_id_calc_date` (`offer_id`,`calc_date`)
) ENGINE=MyISAM AUTO_INCREMENT=52279 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `rko`;
CREATE TABLE `rko` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `bank` varchar(128) NOT NULL,
  `tarif` varchar(128) NOT NULL,
  `service` varchar(128) NOT NULL,
  `payments` varchar(128) NOT NULL,
  `cash_in` varchar(128) NOT NULL,
  `cash_out` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `tags` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `offers_log`;
CREATE TABLE `offers_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT NULL,
  `offer_id` int(11) NOT NULL,
  `suboffer_id` int(11) NOT NULL,
  `suboffer_table` varchar(32) NOT NULL,
  `log` text,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `offers_log_offer_id_IDX` (`offer_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2193 DEFAULT CHARSET=utf8 COMMENT='История изменений офферов';


DROP TABLE IF EXISTS `debit_cards`;
CREATE TABLE `debit_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `img` varchar(64) NOT NULL,
  `service` varchar(32) NOT NULL,
  `cash_out` varchar(64) NOT NULL,
  `interest` varchar(32) NOT NULL,
  `cashback` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `tags` text NOT NULL,
  `payment_systems` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `offers_tags`;
CREATE TABLE `offers_tags` (
  `offer_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`offer_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sites_visitors`;
CREATE TABLE `sites_visitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `this_date` date NOT NULL,
  `visitors` int(11) NOT NULL,
  `yandex_metrika_id` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `this_date_ya_id` (`this_date`,`yandex_metrika_id`)
) ENGINE=MyISAM AUTO_INCREMENT=185649 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `bank_items`;
CREATE TABLE `bank_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `bank_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `type` varchar(16) NOT NULL,
  `name` varchar(128) NOT NULL,
  `address` varchar(128) NOT NULL,
  `latitude` varchar(16) NOT NULL,
  `longitude` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`,`bank_id`,`city_id`,`type`),
  KEY `bank_id` (`bank_id`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102963 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `geo_vk`;
CREATE TABLE `geo_vk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `city_name` varchar(128) NOT NULL,
  `region_iso` varchar(6) NOT NULL,
  `region_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_id` (`city_id`)
) ENGINE=MyISAM AUTO_INCREMENT=158880 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `card_bins`;
CREATE TABLE `card_bins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bin` int(6) NOT NULL,
  `system` varchar(32) NOT NULL,
  `country` varchar(64) NOT NULL,
  `bank` varchar(128) NOT NULL,
  `type` varchar(32) NOT NULL,
  `category` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bin` (`bin`)
) ENGINE=InnoDB AUTO_INCREMENT=135735 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `forms`;
CREATE TABLE `forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lead_time` timestamp NULL DEFAULT NULL,
  `host` varchar(128) NOT NULL,
  `type` varchar(24) NOT NULL,
  `tag` varchar(32) NOT NULL,
  `link` varchar(128) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `sum` int(11) NOT NULL,
  `period` int(8) NOT NULL,
  `surname` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `middlename` varchar(32) NOT NULL,
  `region` varchar(8) NOT NULL,
  `city` varchar(128) NOT NULL,
  `birthday` varchar(24) NOT NULL,
  `email` varchar(32) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `gender` varchar(8) NOT NULL,
  `street` varchar(128) NOT NULL,
  `house` varchar(8) NOT NULL,
  `housing` varchar(8) NOT NULL,
  `flat` varchar(8) NOT NULL,
  `reg_region` varchar(8) NOT NULL,
  `reg_city` varchar(128) NOT NULL,
  `reg_street` varchar(128) NOT NULL,
  `reg_house` varchar(8) NOT NULL,
  `reg_housing` varchar(8) NOT NULL,
  `reg_flat` varchar(8) NOT NULL,
  `passport_number` varchar(16) NOT NULL,
  `passport_date` varchar(16) NOT NULL,
  `passport_code` varchar(16) NOT NULL,
  `passport_issued_by` varchar(128) NOT NULL,
  `birthplace` varchar(128) NOT NULL,
  `occupation` varchar(64) NOT NULL,
  `earning` int(11) NOT NULL,
  `credit_history` varchar(32) NOT NULL,
  `work_experience` int(4) NOT NULL,
  `last_work_experience` int(4) NOT NULL,
  `work_name` varchar(64) NOT NULL,
  `work_position` varchar(64) NOT NULL,
  `work_address` varchar(128) NOT NULL,
  `work_phone` varchar(16) NOT NULL,
  `work_region` varchar(8) NOT NULL,
  `work_city` varchar(128) NOT NULL,
  `work_street` varchar(128) NOT NULL,
  `work_house` varchar(8) NOT NULL,
  `prepay` varchar(128) NOT NULL,
  `object_type` varchar(128) NOT NULL,
  `object_state` varchar(128) NOT NULL,
  `price` varchar(128) NOT NULL,
  `ak_manufacturer` varchar(128) NOT NULL,
  `ak_makes_type` varchar(128) NOT NULL,
  `bk_stage` varchar(128) NOT NULL,
  `bk_company_name` varchar(128) NOT NULL,
  `bk_type` varchar(128) NOT NULL,
  `bk_pledge` varchar(128) NOT NULL,
  `bk_incorporate` varchar(128) NOT NULL,
  `inn` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56697 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `offer_clicks`;
CREATE TABLE `offer_clicks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(16) NOT NULL,
  `region` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `user_agent` varchar(256) NOT NULL,
  `offer_id` int(10) unsigned NOT NULL,
  `offer_subid` int(10) unsigned NOT NULL,
  `form_id` int(10) unsigned NOT NULL,
  `date` timestamp NULL DEFAULT NULL,
  `host` varchar(48) NOT NULL,
  `tag` varchar(32) NOT NULL,
  `cpa` int(11) NOT NULL,
  `visitors` int(11) NOT NULL,
  `ya_client_id` varchar(24) NOT NULL,
  `link_index` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `offer_clicks_offer_id_IDX` (`offer_id`) USING BTREE,
  KEY `offer_clicks_date_IDX` (`date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1298829 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `bank_cities`;
CREATE TABLE `bank_cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city_id` int(11) NOT NULL,
  `city_name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`,`city_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8929 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `credit_cards`;
CREATE TABLE `credit_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `img` varchar(128) NOT NULL,
  `rate` varchar(32) NOT NULL,
  `grace_period` varchar(32) NOT NULL,
  `limit` varchar(32) NOT NULL,
  `process_time` varchar(32) NOT NULL,
  `description` text NOT NULL,
  `tags` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `offer_id` (`offer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `form_offers`;
CREATE TABLE `form_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `cpa` int(11) NOT NULL,
  `epl` int(11) NOT NULL,
  `mct` tinyint(4) NOT NULL,
  `form_types` text NOT NULL,
  `cpa_name` varchar(32) NOT NULL,
  `cpa_offer_id` varchar(128) NOT NULL,
  `fields_set` varchar(32) NOT NULL,
  `min_sum` int(11) NOT NULL,
  `max_sum` int(11) NOT NULL,
  `min_period` int(11) NOT NULL,
  `max_period` int(11) NOT NULL,
  `min_age` tinyint(4) NOT NULL,
  `max_age` tinyint(4) NOT NULL,
  `regions` text NOT NULL,
  `cities` text NOT NULL,
  `regions_native` text NOT NULL,
  `cities_native` text NOT NULL,
  `tags` text NOT NULL,
  `email` varchar(256) NOT NULL,
  `dependencies` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `sites`;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `region` varchar(32) NOT NULL,
  `city` varchar(32) NOT NULL,
  `city_name_rp` varchar(128) NOT NULL,
  `city_name_pp` varchar(128) NOT NULL,
  `city_id` int(11) NOT NULL,
  `footer_text` text NOT NULL,
  `address` text NOT NULL,
  `yandex_metrika_id` varchar(10) NOT NULL,
  `google_analitics_id` varchar(16) NOT NULL,
  `rating_mailru_id` varchar(10) NOT NULL,
  `yandex_verification` varchar(24) NOT NULL,
  `google_verification` varchar(48) NOT NULL,
  `mailru_verification` varchar(48) NOT NULL,
  `li_pwd` varchar(16) NOT NULL,
  `host` varchar(48) NOT NULL,
  `pages_count` int(5) NOT NULL,
  `yandex_indexed` int(5) NOT NULL,
  `google_indexed` int(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `cars`;
CREATE TABLE `cars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(16) NOT NULL,
  `model` varchar(128) NOT NULL,
  `price` varchar(24) NOT NULL,
  `image` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model_UN` (`model`)
) ENGINE=InnoDB AUTO_INCREMENT=417 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `news_host_link`;
CREATE TABLE `news_host_link` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `rss_url` varchar(128) NOT NULL,
  `host` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rss_url_host` (`rss_url`,`host`),
  KEY `host` (`host`)
) ENGINE=InnoDB AUTO_INCREMENT=449859 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `offer_type` varchar(32) NOT NULL,
  `geo` varchar(3) NOT NULL,
  `title` varchar(128) NOT NULL,
  `group` varchar(128) NOT NULL DEFAULT '',
  `order` int(6) unsigned NOT NULL,
  `rules` varchar(255) NOT NULL DEFAULT '',
  `parent_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `u_tag` (`offer_type`,`geo`,`title`)
) ENGINE=InnoDB AUTO_INCREMENT=594 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `forms_epf`;
CREATE TABLE `forms_epf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_type` varchar(32) NOT NULL,
  `epf` int(11) NOT NULL,
  `mct` tinyint(4) NOT NULL,
  `forms_count` int(11) NOT NULL,
  `sum` int(11) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `form_type` (`form_type`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `geo_fias`;
CREATE TABLE `geo_fias` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `city_name` varchar(32) NOT NULL,
  `region_name` varchar(32) NOT NULL,
  `region_code` varchar(2) NOT NULL,
  `region_iso` varchar(8) NOT NULL,
  `unicom_city_code` mediumint(10) unsigned NOT NULL,
  `exbico_city_code` smallint(5) unsigned NOT NULL,
  `exbico_region_code` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `region_iso` (`region_iso`)
) ENGINE=MyISAM AUTO_INCREMENT=1164 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `offers`;
CREATE TABLE `offers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `cpa` int(11) NOT NULL,
  `epc` int(11) NOT NULL COMMENT '-1 нет данных, 0 давно нет конверсий',
  `epc_system` int(11) NOT NULL,
  `mct` tinyint(3) NOT NULL,
  `link` varchar(512) NOT NULL,
  `img` varchar(128) NOT NULL DEFAULT 'no-img.png',
  `bank` varchar(128) NOT NULL,
  `type` varchar(128) NOT NULL,
  `min_rate` varchar(128) NOT NULL,
  `max_sum` varchar(128) NOT NULL,
  `max_period` varchar(128) NOT NULL,
  `process_time` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `cpa_name` varchar(128) NOT NULL,
  `cpa_offer_id` varchar(128) NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT 'RU',
  `regions` text NOT NULL,
  `cities` text NOT NULL,
  `tags` text NOT NULL,
  `min_age_value` tinyint(3) unsigned NOT NULL,
  `max_age_value` tinyint(3) unsigned NOT NULL,
  `min_sum_value` int(10) unsigned NOT NULL,
  `max_sum_value` int(10) unsigned NOT NULL,
  `min_period_value` smallint(5) unsigned NOT NULL,
  `max_period_value` smallint(5) unsigned NOT NULL,
  `top` varchar(32) NOT NULL,
  `test_links` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `credit_cards_tags`;
CREATE TABLE `credit_cards_tags` (
  `credit_card_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`credit_card_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `rko_tags`;
CREATE TABLE `rko_tags` (
  `rko_tarif_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`rko_tarif_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `value` varchar(256) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank_id` int(5) NOT NULL,
  `licence` int(5) NOT NULL,
  `name` varchar(128) NOT NULL,
  `full_name` varchar(128) NOT NULL,
  `link` varchar(128) NOT NULL,
  `image` varchar(128) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `site` varchar(128) NOT NULL,
  `manager` varchar(128) NOT NULL,
  `manager_date` varchar(16) NOT NULL,
  `address` varchar(256) NOT NULL,
  `description` text NOT NULL,
  `actives_sum` varchar(64) NOT NULL,
  `actives_rating` int(4) NOT NULL,
  `profit_sum` varchar(64) NOT NULL,
  `profit_rating` int(4) NOT NULL,
  `update_date` varchar(16) NOT NULL,
  `update_link` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bank_id` (`bank_id`,`licence`),
  UNIQUE KEY `link` (`link`)
) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `postback`;
CREATE TABLE `postback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `offer_id` smallint(6) NOT NULL,
  `cpa_name` varchar(128) NOT NULL,
  `cpa_offer_id` varchar(128) NOT NULL,
  `click_id` int(11) NOT NULL,
  `form_id` int(11) NOT NULL,
  `lead_id` varchar(128) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `status` varchar(48) NOT NULL,
  `sum` int(11) NOT NULL,
  `log` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lead` (`cpa_offer_id`,`lead_id`),
  KEY `click_id` (`click_id`),
  KEY `form_id` (`form_id`),
  KEY `postback_status_IDX` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=281468 DEFAULT CHARSET=utf8;
