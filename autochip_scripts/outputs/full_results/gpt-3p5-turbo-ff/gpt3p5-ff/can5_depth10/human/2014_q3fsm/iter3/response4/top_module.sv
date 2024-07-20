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
    reg [2:0] previous_w;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            previous_w <= 0;
            z <= 0;
        end else begin
            case(state)
                A: begin
                    if (s == 1)
                        state <= B;
                end
                
                B: begin
                    w_count <= (w == 1) ? (w_count + 1) : 0;
                    previous_w <= {previous_w[1:0], w};
                    if (w_count == 3) begin
                        if (previous_w[2] == 1'b1)
                            z <= 1;
                        else
                            z <= 0;
                        w_count <= 0;
                        state <= A;
                    end
                end
            endcase
        end
    end

endmodule
