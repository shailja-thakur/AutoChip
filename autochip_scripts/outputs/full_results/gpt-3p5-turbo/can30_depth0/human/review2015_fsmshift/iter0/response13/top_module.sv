module top_module(
    input clk,
    input reset,
    output shift_ena);
    
    reg [2:0] state;
    
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            state <= 0;
        end else begin
            case(state)
                0: begin
                    shift_ena <= 1;
                    state <= 1;
                end
                1: begin
                    shift_ena <= 1;
                    state <= 2;
                end
                2: begin
                    shift_ena <= 1;
                    state <= 3;
                end
                3: begin
                    shift_ena <= 1;
                    state <= 4;
                end
                4: begin
                    shift_ena <= 0;
                    state <= 0;
                end
                default: begin
                    shift_ena <= 0;
                    state <= 0;
                end
            endcase
        end
    end
    
endmodule
