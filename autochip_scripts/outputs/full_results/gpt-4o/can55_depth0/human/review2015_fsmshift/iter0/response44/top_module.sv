module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    reg [2:0] counter;
    reg state;
    
    // States
    localparam IDLE = 1'b0, ENABLE = 1'b1;

    always @(posedge clk) begin
        if (reset) begin
            counter <= 3'd0;
            state <= ENABLE;
        end else begin
            case (state)
                ENABLE: begin
                    if (counter < 3'd4) begin
                        counter <= counter + 3'd1;
                        shift_ena <= 1'b1;
                    end else begin
                        state <= IDLE;
                        shift_ena <= 1'b0;
                    end
                end
                IDLE: begin
                    shift_ena <= 1'b0;
                end
            endcase
        end
    end
endmodule
