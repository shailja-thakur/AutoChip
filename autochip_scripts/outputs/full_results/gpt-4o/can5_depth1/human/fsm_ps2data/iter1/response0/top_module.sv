module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [23:0] data_reg, next_data_reg;

    // Sequential block for state transition and data update
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            data_reg <= 24'b0;
            out_bytes <= 24'b0;
            done <= 0;
        end else begin
            state <= next_state;
            data_reg <= next_data_reg;
            if (state == BYTE2 && next_state == DONE) begin
                out_bytes <= {data_reg[15:0], in}; // Capture the third byte
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Combinational block for state update and data capture
    always @(*) begin
        next_state = state;
        next_data_reg = data_reg;
        
        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_data_reg = {16'b0, in}; // Store first byte
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_data_reg = {data_reg[15:8], in, data_reg[7:0]}; // Store second byte
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE; // Return to IDLE after signalling done
            end
        endcase
    end

endmodule
