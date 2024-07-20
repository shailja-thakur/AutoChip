module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S0 = 3'b001,  // 0
        S1 = 3'b010,  // 01
        S2 = 3'b011,  // 011
        S3 = 3'b100,  // 0111
        S4 = 3'b101,  // 01111
        S5 = 3'b110,  // 011111
        S6 = 3'b111   // 0111111
    } state_t;

    state_t current_state, next_state;
    reg [2:0] state_counter;

    always @(posedge clk) begin
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
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in == 1'b1) begin
                    next_state = S1;
                end
            end
            S1: begin
                if (in == 1'b1) begin
                    next_state = S2;
                end else begin
                    next_state = IDLE;
                end
            end
            S2: begin
                if (in == 1'b1) begin
                    next_state = S3;
                end else begin
                    next_state = IDLE;
                end
            end
            S3: begin
                if (in == 1'b1) begin
                    next_state = S4;
                end else begin
                    next_state = IDLE;
                end
            end
            S4: begin
                if (in == 1'b1) begin
                    next_state = S5;
                end else begin
                    next_state = IDLE;
                end
            end
            S5: begin
                if (in == 1'b1) begin
                    next_state = S6;
                end else begin
                    next_state = IDLE;
                    disc = 1'b1;
                end
            end
            S6: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    err = 1'b1;
                end else begin
                    next_state = IDLE;
                    flag = 1'b1;
                end
            end
        endcase
    end
endmodule
