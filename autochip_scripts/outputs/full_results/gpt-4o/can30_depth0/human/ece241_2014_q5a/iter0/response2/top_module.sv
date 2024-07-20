module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state, next_state;

    // State encoding
    localparam IDLE = 2'b00;
    localparam FIRST_ONE = 2'b01;
    localparam COMPLEMENT = 2'b10;

    // State transition logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (x == 1)
                    next_state = FIRST_ONE;
                else
                    next_state = IDLE;
            end
            FIRST_ONE: begin
                next_state = COMPLEMENT;
            end
            COMPLEMENT: begin
                next_state = COMPLEMENT;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
            z <= 0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: z <= x;
                FIRST_ONE: z <= x;
                COMPLEMENT: z <= ~x;
            endcase
        end
    end

endmodule
