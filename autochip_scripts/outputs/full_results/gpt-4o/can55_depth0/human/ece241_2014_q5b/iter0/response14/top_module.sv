module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding (one-hot)
    localparam A = 2'b01;
    localparam B = 2'b10;

    reg [1:0] state, next_state;

    // State transition logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;  // Reset to state A
        end else begin
            state <= next_state;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end
endmodule
