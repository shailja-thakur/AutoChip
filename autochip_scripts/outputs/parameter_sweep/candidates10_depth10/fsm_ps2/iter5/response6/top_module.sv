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

    // Internal signals to detect rising edge of reset
    reg reset_rise;

    // FSM logic
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
            reset_rise <= 1'b1;
        end else begin
            reset_rise <= 1'b0;
            case (state)
                IDLE: begin
                    if (reset_rise && in[3] == 1'b1 && count == 0) begin
                        state <= SEARCH;
                        count <= count + 1;
                    end
                end
                SEARCH: begin
                    if (reset_rise) begin
                        state <= IDLE;
                        count <= 0;
                        done <= 1;
                    end else if (count == 2) begin
                        state <= DONE;
                        count <= 0;
                        done <= 0;
                    end else begin
                        state <= SEARCH;
                        count <= count + 1;
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
