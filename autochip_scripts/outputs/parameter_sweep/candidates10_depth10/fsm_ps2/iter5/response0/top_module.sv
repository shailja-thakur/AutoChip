module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Registers for FSM state and current byte count
    reg [1:0] state;
    reg [2:0] count;
    reg start_message;

    // Constants for FSM states
    localparam IDLE = 2'b00;
    localparam SEARCH = 2'b01;
    localparam DONE = 2'b10;

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
            start_message <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        state <= SEARCH;
                        count <= count + 1;
                        start_message <= 1;
                    end
                end
                SEARCH: begin
                    if (count == 2) begin
                        state <= DONE;
                        count <= 0;
                        done <= 1;
                        start_message <= 0;
                    end else begin
                        state <= SEARCH;
                        count <= count + 1;
                    end
                end
                DONE: begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                    start_message <= 0;
                end
            endcase
        end
    end

    // Assertion to check for valid message start
    always @(posedge clk) begin
        if (reset) begin
            assert (start_message == 0) else $error("Invalid message start detected!");
        end
    end

endmodule
