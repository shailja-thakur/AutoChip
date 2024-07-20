module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Registers for FSM state and current byte count
    reg [1:0] state;
    reg [2:0] count;
    reg [7:0] in_prev; // Previous input byte

    // Constants for FSM states
    localparam IDLE = 2'b00;
    localparam SEARCH = 2'b01;
    localparam DONE = 2'b10;

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            in_prev <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    state <= (in[3] == 1'b1) ? SEARCH : IDLE;
                    count <= 0;
                    in_prev <= in;
                end
                SEARCH: begin
                    state <= (count == 2) ? DONE : SEARCH;
                    count <= (in[3] == 1'b1) ? 0 : count + 1;
                    in_prev <= in;
                end
                DONE: begin
                    state <= IDLE;
                    count <= 0;
                    in_prev <= in;
                    done <= 1;
                end
            endcase
        end
    end

    // Check for input byte stream transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            in_prev <= 0;
        end else begin
            if (in != in_prev) begin
                if (state == SEARCH && count < 2 && in[3] == 1'b1) begin
                    // Byte received before completing message, reset count
                    count <= 1;
                end
            end
        end
    end

endmodule
