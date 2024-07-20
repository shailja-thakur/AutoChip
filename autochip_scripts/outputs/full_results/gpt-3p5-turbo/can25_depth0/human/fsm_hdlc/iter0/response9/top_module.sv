module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state, next_state;
    reg [2:0] count;
    reg [2:0] count_ones;
    reg flag_next;

    parameter IDLE = 3'b000;
    parameter RECEIVING = 3'b001;
    parameter DISCARD = 3'b010;
    parameter FLAG = 3'b011;
    parameter ERROR = 3'b100;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            count_ones <= 0;
            flag_next <= 0;
        end else begin
            state <= next_state;
            count <= count + 1;
            count_ones <= (in == 1) ? count_ones + 1 : 0;
            flag_next <= (count == 5 && in == 1) ? 1 : 0;
        end
    end

    always @(state or count_ones) begin
        case (state)
            IDLE: begin
                if (count_ones == 0)
                    next_state = IDLE;
                else if (count_ones == 1)
                    next_state = RECEIVING;
                else if (count_ones == 6)
                    next_state = FLAG;
                else if (count_ones >= 7)
                    next_state = ERROR;
                else
                    next_state = DISCARD;
            end
            RECEIVING: begin
                if (count_ones == 6)
                    next_state = FLAG;
                else if (count_ones >= 7)
                    next_state = ERROR;
                else
                    next_state = RECEIVING;
            end
            DISCARD: begin
                if (count_ones == 0)
                    next_state = RECEIVING;
                else if (count_ones >= 7)
                    next_state = ERROR;
                else
                    next_state = DISCARD;
            end
            FLAG: begin
                if (count_ones == 0)
                    next_state = RECEIVING;
                else if (flag_next == 1)
                    next_state = IDLE;
                else if (count_ones >= 7)
                    next_state = ERROR;
                else
                    next_state = FLAG;
            end
            ERROR: begin
                if (count_ones == 0)
                    next_state = RECEIVING;
                else if (count_ones >= 7)
                    next_state = ERROR;
                else
                    next_state = DISCARD;
            end
        endcase
    end

    always @(posedge clk) begin
        disc <= (state == DISCARD) ? 1 : 0;
        flag <= (state == FLAG) ? 1 : 0;
        err <= (state == ERROR) ? 1 : 0;
    end

endmodule
