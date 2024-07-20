module top_module (
    input clk,
    input in,
    input reset,
    output done
);
    reg [2:0] state;
    reg start_bit;
    reg [7:0] data_bits;
    reg stop_bit;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            start_bit <= 1;
            data_bits <= 0;
            stop_bit <= 1;
            done <= 0;
        end
        else begin
            case (state)
                0: begin
                    if (in == 0) begin
                        state <= 1;
                        start_bit <= 0;
                    end
                end
                
                1: begin
                    state <= 2;
                    data_bits <= {data_bits[6:0], in};
                end
                
                2 to 7: begin
                    state <= state + 1;
                    data_bits <= {data_bits[6:0], in};
                end
                
                8: begin
                    state <= 9;
                    stop_bit <= in;
                end
                
                9: begin
                    if (in == 1) begin
                        state <= 0;
                        done <= 1;
                    end
                    else begin
                        state <= 8;
                        stop_bit <= 1;
                    end
                end
            endcase
        end
    end
endmodule
