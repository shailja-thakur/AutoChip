module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [2:0] {
        S_IDLE      = 3'b000,
        S_1         = 3'b001,
        S_2         = 3'b010,
        S_3         = 3'b011,
        S_4         = 3'b100,
        S_5         = 3'b101,
        S_6         = 3'b110,
        S_7         = 3'b111
    } state_t;

    state_t state, next_state;

    // State Transition Logic
    always @(*) begin
        case (state)
            S_IDLE: begin
                if (in)
                    next_state = S_1;
                else
                    next_state = S_IDLE;
            end
            S_1: begin 
                if (in)
                    next_state = S_2;
                else
                    next_state = S_IDLE;
            end
            S_2: begin 
                if (in)
                    next_state = S_3;
                else
                    next_state = S_IDLE;
            end
            S_3: begin 
                if (in)
                    next_state = S_4;
                else
                    next_state = S_IDLE;
            end
            S_4: begin 
                if (in)
                    next_state = S_5;
                else
                    next_state = S_IDLE;
            end
            S_5: begin 
                if (in)
                    next_state = S_6;
                else begin
                    next_state = S_IDLE;
                    disc = 1;
                end
            end
            S_6: begin
                if (in)
                    next_state = S_7;
                else begin
                    next_state = S_IDLE;
                    flag = 1;
                end
            end
            S_7: begin
                if (in)
                    next_state = S_7;
                else
                    next_state = S_IDLE;
                err = 1;
            end
            default: next_state = S_IDLE;
        endcase
    end

    // State Register Logic
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Output Logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 0;
            flag <= 0;
            err <= 0;
        end
        else begin
            disc <= (next_state == S_5 && state == S_5 && in == 0);
            flag <= (next_state == S_6 && state == S_6 && in == 0);
            err <= (next_state == S_7 || (state == S_7 && in == 1));
        end
    end
endmodule
