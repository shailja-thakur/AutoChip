module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    parameter A = 0;  // State A
    parameter B = 1;  // State B
    
    reg state;
    reg z;
    
    always @(posedge clk) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    state <= B;
                end
            endcase
        end
    end
    
    always @(state or x) begin
        if ((state == A && x) || (state == B && !x)) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end

endmodule
