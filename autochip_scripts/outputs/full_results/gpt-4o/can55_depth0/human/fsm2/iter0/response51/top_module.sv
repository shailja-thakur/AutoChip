module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    typedef enum reg [1:0] {
        OFF = 2'd0,
        ON = 2'd1
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: 
                if (j) begin
                    next_state = ON;
                end else begin
                    next_state = OFF;
                end
            ON: 
                if (k) begin
                    next_state = OFF;
                end else begin
                    next_state = ON;
                end
            default:
                next_state = OFF;
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == ON);
    end

    // State update logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

endmodule
