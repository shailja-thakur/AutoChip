module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

    // Registers for FSM state and current byte count
    reg [1:0] state;
    reg [2:0] count;

    // Constants for FSM states
    localparam IDLE = 2'b00;
    localparam SEARCH = 2'b01;
    localparam DONE = 2'b10;

    // Internal signal for detecting the start of a message
    wire start;

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        state <= SEARCH;
                        start <= 1;
                    end else begin
                        state <= IDLE;
                    end
                    count <= 0;
                end
                SEARCH: begin
                    if (start) begin
                        count <= count + 1;
                    end
                    if (count == 2) begin
                        state <= DONE;
                        done <= 1;
                    end else if (in[3] == 1'b1) begin
                        start <= 1;
                    end else begin
                        start <= 0;
                    end
                end
                DONE: begin
                    state <= IDLE;
                    count <= 0;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
