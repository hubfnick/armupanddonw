(load "package://dxl_armed_turtlebot/euslisp/dxl-armed-turtlebot-interface.l")

(ros::roseus "check3")

(setq m 0)
(dxl-armed-turtlebot-init)

(ros::roseus-add-msgs "image_view2")

(ros::ros-info "send initial pose")
(send *ri* :angle-vector #f(80 0 45 0 45 45) 1000)
(send *dxl-armed-turtlebot* :reset-pose)
;;(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 3000)
(send *ri* :wait-interpolation)
;;(send *dxl-armed-turtlebot* :gripper :arm :angle-vector #f(50))
(ros::ros-info "start !!!")
(ros::rate 10)
(do-until-key ;; Enterでループを抜ける
 ;;(ros::subscribe "image_marker2" image_view2::ImageMarker2 #'cb)
;;(ros::ros-info (send *ri* :state :bumper-vector))
 (when (= (elt (send *ri* :state :bumper-vector) 0) 1)
   (ros::ros-info "down.")
   (send *dxl-armed-turtlebot* :arm :move-end-pos
	 (float-vector 0 0 20) :world :rotation-axis nil) ;; 手先を20mm上に移動
   (send *irtviewer* :state :draw-objects)
   (send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 1000)

   (send *ri* :wait-interpolation)
   )
 (when  (= (elt (send *ri* :state :bumper-vector) 1) 1)
   (ros::ros-info "left.")
   ;;(send *dxl-armed-turtlebot* :arm :move-end-pos
;;	 (float-vector 0 -20 0) :world :rotation-axis nil) ;; 手先を20mm上に移動
  ;; (send *irtviewer* :draw-objects)
   ;;(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 1000)

   ;;(send *ri* :wait-interpolation)
   )
 (when  (= (elt (send *ri* :state :bumper-vector) 2) 1)
   (ros::ros-info "up.")
 ;;  (send *dxl-armed-turtlebot* :arm :move-end-pos
;;	 (float-vector 0 0 20) :world :rotation-axis nil) ;; 手先を20mm上に移動
  ;; (send *irtviewer* :draw-objects)
  ;; (send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 1000)

;;   (send *ri* :wait-interpolation)
   )
 ;;(when (not (= (send *ri* :bumper-vector) #f(0 0 0)))
   ;;(ros::ros-info "bump.")
  ;; (setq m (+ m 1))
;;   (if (> m 1) (setq m (- m 2)))
  ;; (send *irtviewer* :draw-objects)
   ;;(send *ri* :angle-vector (send *dxl-armed-turtlebot* :angle-vector) 1000)
   ;;(send *ri* :move-gripper 50)
  ;; (if (= m 1) (send *ri* :start-grasp))
  ;; (if (= m 0) (send *ri* :stop-grasp))
  ;; (send *ri* :wait-interpolation)
   ;;)
 (x::window-main-one)
 (ros::sleep)
 (ros::spin-once)
 )
