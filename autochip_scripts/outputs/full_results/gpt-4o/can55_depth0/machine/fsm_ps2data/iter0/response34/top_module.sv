module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic[1:0] {
        BYTE1 = 2'b00,
        BYTE2 = 2'b01,
        BYTE3 = 2'b10,
        DONE  = 2'b11
    } state_t;

    state_t state, next_state;

    reg [23:0] out_reg, out_reg_next;

    // State machine
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= BYTE1;
            out_reg <= 24'b0;
        end else begin
            state <= next_state;
            out_reg <= out_reg_next;
        end
    end

    always_comb begin
        next_state = state;
        out_reg_next = out_reg;
        done = 1'b0;

        case (state)
            BYTE1: begin
                if (in[2]) begin // check if third bit is 1
                    next_state = BYTE2;
                    out_reg_next = {out_reg[15:0], in};
                end else begin
                    next_state = BYTE1;
                end
            end

            BYTE2: begin
                next_state = BYTE3;
                out_reg_next = {out_reg[15:0], in};
            end

            BYTE3: begin
                next_state = DONE;
                out_reg_next = {out_reg[15:0], in};
            end

            DONE: begin
                done = 1'b1;
                out_bytes = out_reg;

                if (~in[2]) begin // reset condition from DONE state to BYTE1
                    next_state = BYTE1;
                    out_reg_next = 24'b0;
                end
            end

            default: begin
                next_state = BYTE1;
            end
        endcase
    end

    // output in other states
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out_bytes <= 24'b0;
        end else if (done) begin
            out_bytes <= out_reg;
        end
    end

endmodule
