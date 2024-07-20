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

    // Internal signals
    wire [3:0] in3;
    assign in3 = in[3:0];

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in3 == 4'b0001) begin
                        state <= SEARCH;
                        count <= 1;
                    end
                end
                SEARCH: begin
                    if (count == 2) begin
                        state <= DONE;
                        count <= 0;
                        done <= 1;
                    end else if (in3 == 4'b0001) begin
                        count <= count + 1;
                    end else begin
                        count <= 0;
                        state <= IDLE;
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
