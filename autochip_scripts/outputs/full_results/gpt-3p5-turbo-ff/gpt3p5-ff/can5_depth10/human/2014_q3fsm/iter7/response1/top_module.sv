module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    parameter A = 0;
    parameter B = 1;
    
    reg [1:0] state;
    reg [2:0] w_count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            z <= 0;
        end else begin
            case(state)
                A: begin
                    if (s == 1)
                        state <= B;
                end
                
                B: begin
                    if (w == 1)
                        w_count <= w_count + 1;
                    if (w_count == 2) begin
                        z <= 1;
                    end else begin
                        z <= 0;
                    end
                    if (w_count == 3) begin
                        state <= A;
                        w_count <= 0;
                    end
                end
            endcase
        end
    end

endmodule
