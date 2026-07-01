module traffic_controller(
    input clk,
    input reset,

    output reg A_red,
    output reg A_yellow,
    output reg A_green,

    output reg B_red,
    output reg B_yellow,
    output reg B_green,

    output reg C_red,
    output reg C_yellow,
    output reg C_green,

    output reg D_red,
    output reg D_yellow,
    output reg D_green
);
parameter B_GREEN  = 3'd0,
          B_YELLOW = 3'd1,
          C_GREEN  = 3'd2,
          C_YELLOW = 3'd3,
          D_GREEN  = 3'd4,
          D_YELLOW = 3'd5,
          A_GREEN  = 3'd6,
          A_YELLOW = 3'd7;

          reg [2:0] state;
          reg [6:0] timer;

          parameter green_time = 30;
          parameter yellow_time = 5;

          always @(posedge clk or posedge reset) begin
            if(reset) begin
            state <= B_GREEN;
            timer <= 0;
            end
            else begin 
                timer <= timer + 1;

                case(state)

                B_GREEN:
                if(timer == green_time) begin
                    state <= B_YELLOW;
                    timer <= 0;
                end

                B_YELLOW:
                if(timer == yellow_time) begin
                    state <= C_GREEN;
                    timer <= 0;
                end

                C_GREEN:
                if(timer == green_time) begin
                    state <= C_YELLOW;
                    timer <= 0;
                end

                C_YELLOW:
                if(timer == yellow_time) begin
                    state <= D_GREEN;
                    timer <= 0;
                end

                D_GREEN:
                if(timer == green_time) begin
                    state <= D_YELLOW;
                    timer <= 0;
                end

                D_YELLOW:
                if(timer == yellow_time) begin
                    state <= A_GREEN;
                    timer <= 0;
                end

                A_GREEN:
                if(timer == green_time) begin
                    state <= A_YELLOW;
                    timer <= 0;
                end

                A_YELLOW:
                if(timer == yellow_time) begin
                    state <= B_GREEN;
                    timer <= 0;
                end
                default: begin
                     state <= B_GREEN;
                     timer <= 0;
                end
                endcase
            end
          end 

          always @(*) begin

                 A_red = 0;
                 A_yellow = 0;
                 A_green = 0;

                 B_red = 0;
                 B_yellow = 0;
                 B_green = 0;

                 C_red = 0; 
                 C_yellow = 0;
                 C_green = 0;

                 D_red = 0;
                 D_yellow = 0;
                 D_green = 0;

             case(state)

              B_GREEN: begin
                 A_red   = 1;
                 B_green = 1;
                 C_red   = 1;
                D_red   = 1;
        end

              B_YELLOW: begin
                 A_red      = 1;
                 B_yellow   = 1;
                 C_red      = 1;
                 D_red      = 1;
        end

              C_GREEN: begin
                 A_red   = 1;
                 B_red   = 1;
                 C_green = 1;
                 D_red   = 1;
        end

              C_YELLOW: begin
                 A_red      = 1;
                 B_red      = 1;
                 C_yellow   = 1;
                 D_red      = 1;
        end

             D_GREEN: begin
                 A_red   = 1;
                 B_red   = 1;
                 C_red   = 1;
                 D_green = 1;
        end

             D_YELLOW: begin
                 A_red      = 1;
                 B_red      = 1;
                 C_red      = 1;
                 D_yellow   = 1;
        end

             A_GREEN: begin
                 A_green = 1;
                 B_red   = 1;
                 C_red   = 1;
                 D_red   = 1;
        end

             A_YELLOW: begin
                 A_yellow = 1;
                 B_red    = 1;
                 C_red    = 1;
                 D_red    = 1;
        end

        default: begin
            A_red = 1;
            B_red = 1;
            C_red = 1;
            D_red = 1;
        end

    endcase
end

endmodule 