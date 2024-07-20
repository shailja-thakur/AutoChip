module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    reg [1:0] state, next_state;
    reg [2:0] w_count;
  
    parameter A = 2'b00, B = 2'b01;
  
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 3'b0;
            z <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                A: begin
                    if (s == 1'b1)
                        next_state = B;
                    else
                        next_state = A;
                end
                B: begin
                    if (w == 1'b1) begin
                        w_count <= w_count + 1'b1;
                        if (w_count == 3'b10)
                            z <= 1'b1;
                    end else begin
                        w_count <= w_count;
                        z <= 1'b0;
                    end
                    if (w == 1'b0) begin
                        w_count <= 3'b0;
                    end
                    next_state = B;
                end
                default: begin
                    next_state = A;
                end
            endcase
        end
    end
endmodule
