module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

    reg [1:0] state, next_state;
    reg [23:0] msg;

    // State Encoding
    localparam IDLE = 2'b00,
               BYTE1 = 2'b01,
               BYTE2 = 2'b10,
               DONE = 2'b11;
    
    // State Transition Logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next State Logic and Output Logic
    always @(*) begin
        next_state = state;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (in[3] == 1'b1) begin
                    next_state = BYTE1;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
                done = 1'b1;
            end
        endcase
    end

    // Output and Data Handling
    always @(posedge clk) begin
        if (reset) begin
            msg <= 24'b0;
            out_bytes <= 24'b0;
        end else begin
            case (next_state)
                BYTE1: msg[23:16] <= in; // First byte
                BYTE2: msg[15:8] <= in;  // Second byte
                DONE: begin
                    msg[7:0] <= in;       // Third byte
                    out_bytes <= msg;
                end
                default: begin
                    msg <= 24'b0;
                end
            endcase
        end
    end

endmodule
