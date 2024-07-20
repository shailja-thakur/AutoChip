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
                    previous_w <= {previous_w[1:0], w};
                    w_count <= (previous_w == 3'b001 || previous_w == 3'b010) ? w_count + 1 : 0;
                    if (w_count == 2) begin
                        state <= A;
                        if(previous_w==3'b010)
                            z <= 1;
                        else
                            z <= 0; 
                    end else begin
                        state <= B;
                        z <= 0;
                    end
                end
            endcase
        end
    end

endmodule
