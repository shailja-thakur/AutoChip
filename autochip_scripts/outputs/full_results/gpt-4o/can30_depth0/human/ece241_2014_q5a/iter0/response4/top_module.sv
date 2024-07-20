module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state, next_state;
    reg flip; // To keep track of flipping bits after the first '1'.

    // State encoding
    parameter S_WAIT = 2'b00, S_COMPLEMENT = 2'b01;

    // Next state logic (Moore machine state transitions)
    always @(*) begin
        case (state)
            S_WAIT: begin
                if (x == 1) // Detected the first '1'
                    next_state = S_COMPLEMENT;
                else
                    next_state = S_WAIT;
            end
            S_COMPLEMENT: begin
                next_state = S_COMPLEMENT; // Remain in complementing state
            end
            default: next_state = S_WAIT;
        endcase
    end

    // Output logic (Moore machine output based on state)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= S_WAIT;
            z <= 0;
            flip <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                S_WAIT: begin
                    z <= x; // Output the bit as it is in WAIT state
                    if (x == 1) begin
                        flip <= 1'b1; // Start flipping bits after the first '1'
                    end
                end
                S_COMPLEMENT: begin
                    if (flip) begin
                        z <= ~x; // Flip the bit in COMPLEMENT state
                    end
                    else begin
                        z <= x;
                    end
                end
            endcase
        end
    end

endmodule
