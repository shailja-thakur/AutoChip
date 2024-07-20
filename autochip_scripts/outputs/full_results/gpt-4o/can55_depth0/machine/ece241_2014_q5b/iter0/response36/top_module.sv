module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // Define states
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state;

    // State transitions and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            z <= 0;
        end else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B;
                        z <= 1;
                    end else begin
                        state <= A;
                        z <= 0;
                    end
                end
                B: begin
                    state <= B;
                    z <= ~x;
                end
            endcase
        end
    end
endmodule
