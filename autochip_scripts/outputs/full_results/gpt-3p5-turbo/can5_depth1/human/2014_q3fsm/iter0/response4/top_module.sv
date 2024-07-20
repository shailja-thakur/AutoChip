module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    parameter A = 1'b0;
    parameter B = 1'b1;
    
    reg [1:0] state;
    reg [2:0] count_w;
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= A;
            z <= 1'b0;
        end else begin
            case (state)
                A: begin
                    if (s == 1'b1) begin
                        state <= B;
                        count_w <= 0;
                    end
                end
                B: begin
                    count_w <= count_w + 1;
                    if (count_w == 3) begin
                        if (count_w == 2) begin
                            z <= 1'b1;
                        end else begin
                            z <= 1'b0;
                        end
                        count_w <= 0;
                    end
                end
            endcase
        end
    end
    
endmodule
