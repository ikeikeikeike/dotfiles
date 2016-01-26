# -*- coding: utf-8 -*-
from django.conf import settings
from ad_admin.models import Campaigns


BUDGET_CAP_KEY = "ad_budget_cap:{}"
BUDGET_CAP_RATES = {
    0: 6,
    1: 9,
    2: 10,
    3: 11,
    4: 12,
    5: 14,
    6: 18,
    7: 23,
    8: 31,
    9: 35,
    10: 39,
    11: 42,
    12: 49,
    13: 52,
    14: 56,
    15: 62,
    16: 65,
    17: 71,
    18: 77,
    19: 81,
    20: 86,
    21: 93,
    22: 97,
    23: 100
}


def get_active_campaigns():
    """
    配信中のキャンペーンを取得する
    """
    return ""

def get_inactive_campaigns():
    """
    配信中でないキャンペーンを取得する
    """
    return ""

def get_campaign_budget_rates(campaign):
    """
    キャンペーンの予算比率を取得する
    """
    # TODO: アドネ比率，時間帯予算の考慮
    # Gunosy配信のみの場合

    # アドネ配信のみの場合

    # Gunosy配信，アドネ配信の両方を含む場合

    return BUDGET_CAP_RATES

def get_daily_budget(campaign):
    """
    日予算を取得する
    """
    # TODO: 月予算，全体予算を考慮した日予算の計算
    return campaign.daily_budget


def calc_budget_cap(daily_budget, budget_cap_rates):
    """
    日予算と予算比率から時間帯予算を計算する
    """
    budget_cap = {}
    for h, rate in budget_cap_rates:
        budget_cap[h] = daily_budget * rate / 100.0
    return budget_cap


def get_budget_cap(campaign):
    """
    キャンペーンの予算上限を取得する
    """
    # 日予算を取得
    daily_budget = get_daily_budget(campaign)

    # 時間帯別の比率を取得
    cap_rates = get_campaign_budget_rates(campaign)

    # 時間帯予算を計算
    budget_cap = calc_budget_cap(daily_budget, cap_rates)

    return budget_cap


def update_budget_cap():
    """
    予算上限の更新
    MessagePackでパッキングしてDBに挿入
    """

    # 配信中のキャンペーンの時間帯の予算上限を登録
    # 対象のキャンペーンを取得
    campaigns = get_active_campaigns()
    for campaign in campaigns:
        # 日予算の取得
        budget_cap = get_budget_cap(campaign)
        # Msgpackでパック
        packed = msgpack.packb(budget_cap)
        # Redisに登録する（プロト用．本番はLevelDB）
        redis_cli.set(BUDGET_CAP_KEY.format(campaign.id), packed)

    # 配信中でないキャンペーンの予算上限を削除
    campaigns = get_inactive_campaigns()
    for campaign in campaigns:
        redis_cli.delete(BUDGET_CAP_KEY.format(campaign.id))
