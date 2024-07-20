module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

reg [2:0] state, next_state;
parameter WAIT_0 = 3'b000,
          WAIT_1 = 3'b001,
          WAIT_2 = 3'b010,
          WAIT_3 = 3'b011,
          WAIT_4 = 3'b100,
          WAIT_5 = 3'b101,
          FLAG   = 3'b110,
          ERROR  = 3'b111;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        WAIT_0: begin
            if (in == 1'b0) next_state = WAIT_0;
            else next_state = WAIT_1;
        end
        WAIT_1: begin
            if (in == 1'b0) next_state = WAIT_0;
            else next_state = WAIT_2;
        end
        WAIT_2: begin
            if (in == 1'b0) next_state = WAIT_0;
            else next_state = WAIT_3;
        end
        WAIT_3: begin
            if (in == 1'b0) next_state = WAIT_0;
            else next_state = WAIT_4;
        end
        WAIT_4: begin
            if (in == 1'b0) next_state = WAIT_0;
            else next_state = WAIT_5;
        end
        WAIT_5: begin
            if (in == 1'b0) begin
                disc = 1'b1;
                next_state = WAIT_0;
            end
            else next_state = FLAG;
        end
        FLAG: begin
            flag = 1'b1;
            next_state = WAIT_0;
        end
        ERROR: begin
            err = 1'b1;
            next_state = WAIT_0;
        end
        default: next_state = WAIT_0;
    endcase

    if (state == WAIT_5 && in == 1'b1) next_state = ERROR;
end

endmodule
