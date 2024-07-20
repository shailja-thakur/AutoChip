module top_module(
    input clk,
    input reset,
    output reg shift_ena);
    
    reg [3:0] state;
    localparam IDLE = 0, DETECT_PATTERN = 1, SHIFT_ENA = 2;
    
    always @ (posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 1'b0;
        end else begin
            case (state)
                IDLE:
                    if (/* Add your condition here for detecting the proper bit pattern */) begin
                        state <= DETECT_PATTERN;
                    end
                DETECT_PATTERN:
                    if (shift_ena) begin
                        state <= SHIFT_ENA;
                    end else begin
                        state <= IDLE;
                    end
                SHIFT_ENA:
                    state <= IDLE;
            endcase
        end
    end
    
    always @ (posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b0;
        end else begin
            case (state)
                IDLE:
                    shift_ena <= 1'b0;
                DETECT_PATTERN:
                    shift_ena <= 1'b1;
                SHIFT_ENA:
                    shift_ena <= 1'b0;
            endcase
        end
    end
endmodule
