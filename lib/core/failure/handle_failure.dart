import 'package:flutter/material.dart';
import 'package:saglixen/core/contants/string_constansts.dart';
import 'package:saglixen/core/failure/failure.dart';
import 'package:saglixen/core/widgets_wraper/custom_toast_mesega.dart';
import 'package:saglixen/presentation/login_page/login_page.dart';

void handleFailure(BuildContext ctx, Failure fail) {
  void goster(String mesaj) =>
      CustomToast.show(ctx, mesaj, hata: true);

  switch (fail) {
    case UnkonwFailure():
      goster(StringConstants.unknow);
    case NetworkFailure():
      goster(StringConstants.network);
    case TimeoutFailure():
      goster(StringConstants.timeout);
    case UnAuntHorizedfail():
      goster(StringConstants.unAuthorized);
      Future.delayed(const Duration(seconds: 2), () async {
        if (!ctx.mounted) return;
        await Navigator.pushAndRemoveUntil(
          ctx,
          LoginPage.route(),
          (_) => false,
        );
      });
    case NotFoundFailer():
      goster(StringConstants.notFound);
  }
}
