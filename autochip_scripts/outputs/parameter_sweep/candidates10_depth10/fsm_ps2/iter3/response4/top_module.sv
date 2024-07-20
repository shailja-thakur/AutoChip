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

    // Internal signal to hold the value of in[3]
    reg in_3;

    // Assign in[3] to in_3 to avoid potential combinational loop
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            in_3 <= 1'b0;
        end else begin
            in_3 <= in[3];
        end
    end

    // FSM logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            done <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (in_3 == 1'b1) begin
                        state <= SEARCH;
                        count <= 1;
                    end else begin
                        state <= IDLE;
                        count <= 0;
                    end
                end
                SEARCH: begin
                    if (count == 2) begin
                        state <= DONE;
                        done <= 1;
                    end else begin
                        if (in_3 == 1'b1) begin
                            state <= SEARCH;
                            count <= count + 1;
                        end else begin
                            state <= IDLE;
                            count <= 0;
                        end
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
