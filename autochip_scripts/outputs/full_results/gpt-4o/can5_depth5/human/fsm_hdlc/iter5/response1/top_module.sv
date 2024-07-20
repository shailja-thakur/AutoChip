module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100,
        S5 = 3'b101,
        S6 = 3'b110,
        S7 = 3'b111
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        disc = 1'b0;
        flag = 1'b0;
        err = 1'b0;

        case (current_state)
            IDLE: begin
                if (in)
                    next_state = S1;
                else
                    next_state = IDLE;
            end
            S1: begin
                if (in)
                    next_state = S2;
                else
                    next_state = IDLE;
            end
            S2: begin
                if (in)
                    next_state = S3;
                else
                    next_state = IDLE;
            end
            S3: begin
                if (in)
                    next_state = S4;
                else
                    next_state = IDLE;
            end
            S4: begin
                if (in)
                    next_state = S5;
                else
                    next_state = IDLE;
            end
            S5: begin
                if (in)
                    next_state = S6;
                else begin
                    disc = 1'b1;
                    next_state = IDLE;
                end
            end
            S6: begin
                if (in)
                    next_state = S7;
                else begin
                    flag = 1'b1;
                    next_state = IDLE;
                end
            end
            S7: begin
                if (in) begin
                    err = 1'b1;
                    next_state = S7;
                end else begin
                    flag = 1'b1;
                    next_state = IDLE;
                end
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
