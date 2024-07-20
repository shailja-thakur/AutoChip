module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);
    
    reg [2:0] state;
    reg [7:0] data_byte;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            data_byte <= 0;
            done <= 0;
            out_byte <= 0;
        end else begin
            case (state)
                0: begin
                    if (in == 1'b0) begin
                        state <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                
                1: begin
                    state <= 2;
                    data_byte <= in;
                end
                
                2 to 9: begin
                    state <= state + 1;
                    data_byte <= {data_byte[6:0], in};
                end
                
                10: begin
                    if (in == 1'b1) begin
                        state <= 0;
                        done <= 1;
                        out_byte <= data_byte;
                    end else begin
                        state <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end
    
endmodule
