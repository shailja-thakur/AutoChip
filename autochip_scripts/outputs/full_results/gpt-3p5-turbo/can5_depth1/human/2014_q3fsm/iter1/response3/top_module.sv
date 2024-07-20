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
    reg [1:0] w_previous;
    reg [2:0] w_count;
    
    always @(posedge clk) begin
        if (reset == 1'b1) begin
            state <= A;
            z <= 1'b0;
            count_w <= 0;
            w_previous <= 2'b00;
            w_count <= 0;
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
                    w_count <= w_count + (w == w_previous ? 1 : 0);
                    if (count_w == 2) begin
                        if (w_count == 2) begin
                            z <= 1'b1;
                        end else begin
                            z <= 1'b0;
                        end
                        count_w <= 0;
                        w_previous <= w;
                        w_count <= 0;
                    end
                end
            endcase
        end
    end
    
endmodule
