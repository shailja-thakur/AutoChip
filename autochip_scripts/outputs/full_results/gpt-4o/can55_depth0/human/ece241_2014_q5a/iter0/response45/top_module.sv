module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State definitions
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        COMPLEMENT = 2'b01,
        ADD_ONE = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg carry;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= IDLE;
            z <= 0;
            carry <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                next_state = COMPLEMENT;
                z = 0;
                carry = 0;
            end

            COMPLEMENT: begin
                if (x == 1'b1) begin
                    z = 1'b0;
                end else begin
                    z = 1'b1;
                end
                next_state = ADD_ONE;
            end

            ADD_ONE: begin
                if (carry == 0) begin
                    if (z == 1'b1) begin
                        z = 1'b0;
                        carry = 1;
                    end else begin
                        z = 1'b1;
                        carry = 0;
                    end
                end else begin
                    if (z == 1'b1) begin
                        z = 1'b0;
                        carry = carry;
                    end else begin
                        z = 1'b1;
                        carry = 0;
                    end
                end

                next_state = DONE;
            end

            DONE: begin
                if (~areset) begin
                    next_state = COMPLEMENT;
                end else begin
                    next_state = IDLE;
                end
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
