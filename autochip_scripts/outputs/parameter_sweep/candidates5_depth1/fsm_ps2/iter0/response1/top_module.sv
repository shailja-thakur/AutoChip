module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    
    // Internal signals
    reg [7:0] input_byte1;
    reg [7:0] input_byte2;
    reg [7:0] input_byte3;
    reg [2:0] state;
    reg done_reg;
    
    // Register assignments on positive edge of the clock
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            done_reg <= 0;
        end else begin
            case(state)
                0: begin
                    if (in[3] == 1) begin
                        input_byte1 <= in;
                        state <= 1;
                    end
                end
                1: begin
                    input_byte2 <= in;
                    state <= 2;
                end
                2: begin
                    input_byte3 <= in;
                    state <= 3;
                end
                3: begin
                    done_reg <= 1;
                    state <= 0;
                end
                default: state <= 0;
            endcase
        end
    end
    
    // Output assignment
    assign done = done_reg;
    
endmodule
