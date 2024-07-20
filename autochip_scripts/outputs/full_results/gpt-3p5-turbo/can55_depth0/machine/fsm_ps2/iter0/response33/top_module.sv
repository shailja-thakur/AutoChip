module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

    // Define the states
    reg [1:0] state;
    localparam BYTE1 = 2'b00;
    localparam BYTE2 = 2'b01;
    localparam BYTE3 = 2'b10;
    localparam DONE = 2'b11;

    // Flip-flop for holding the state
    reg [1:0] next_state;

    // Output signals
    wire third_bit;
    assign third_bit = in[2];

    // State register
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= BYTE1;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(state, third_bit) begin
        case (state)
            BYTE1: begin
                if (third_bit) begin
                    next_state <= BYTE2;
                end else begin
                    next_state <= BYTE1;
                end
            end

            BYTE2: begin
                next_state <= BYTE3;
            end

            BYTE3: begin
                next_state <= DONE;
            end

            DONE: begin
                if (third_bit) begin
                    next_state <= BYTE2;
                end else begin
                    next_state <= BYTE1;
                end
            end
        endcase
    end

    // Done output
    assign done = (state == DONE);

endmodule
