module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'd0,
        BYTE1 = 2'd1,
        BYTE2 = 2'd2,
        DONE = 2'd3
    } state_t;

    state_t state, next_state;
    reg [23:0] message;
    reg [7:0] byte_counter;

    // State transition
    always_ff @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in[3]) // Start byte detection
                    next_state = BYTE1;
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                done = 1'b1; // Signal done
                next_state = IDLE; // Reset to IDLE to look for new message
            end
        endcase
    end

    // Output and message storage logic
    always_ff @(posedge clk) begin
        if (reset) begin
            out_bytes <= 24'b0;
            message <= 24'b0;
            byte_counter <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    byte_counter <= 8'b0;
                end
                BYTE1: begin                   
                    message[23:16] <= in;
                    byte_counter <= byte_counter + 1;
                end
                BYTE2: begin
                    message[15:8] <= in;
                    byte_counter <= byte_counter + 1;
                end
                DONE: begin
                    message[7:0] <= in;
                    out_bytes <= message;
                    byte_counter <= 8'b0;
                end
            endcase
            if (done) begin
                out_bytes <= message;
            end
        end
    end

endmodule
