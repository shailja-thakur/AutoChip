module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State variables
    reg state;
    parameter A = 1'b0, B = 1'b1;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: begin
                if (j) begin
                    state = B;
                end else begin
                    state = A;
                end
            end
            B: begin
                if (k) begin
                    state = A;
                end else begin
                    state = B;
                end
            end
            default: begin
                state = A;
            end
        endcase
    end

    // Sequential logic to update state
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= state;
        end
    end

    // Assign output based on current state
    always @(*) begin
        if (state == B) begin
            out = 1'b1;
        end else begin
            out = 1'b0;
        end
    end

endmodule
