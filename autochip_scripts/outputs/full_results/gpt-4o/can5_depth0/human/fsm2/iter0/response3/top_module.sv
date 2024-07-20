module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // Define the state encoding
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;

    // State registers
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON:  if (k) next_state = OFF;
                 else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State register update
    always @(posedge clk or posedge areset) begin
        if (areset) state <= OFF;
        else state <= next_state;
    end

    // Output logic based on state
    always @(posedge clk or posedge areset) begin
        if (areset) out <= 0;
        else begin
            case (state)
                OFF: out <= 0;
                ON:  out <= 1;
                default: out <= 0;
            endcase
        end
    end

endmodule
