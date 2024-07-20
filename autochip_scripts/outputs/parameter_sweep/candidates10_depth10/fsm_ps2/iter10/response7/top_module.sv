module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg done
);

    // Registers for FSM state and current byte count
    reg [1:0] state;
    reg [2:0] count;

    // Constants for FSM states
    localparam IDLE = 2'b00;
    localparam SEARCH = 2'b01;
    localparam DONE = 2'b10;

    // Intermediate registers to capture in[3]
    reg in3_reg;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            in3_reg <= 1'b0;
        end else begin
            in3_reg <= in[3];
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
                    if (in3_reg == 1'b1) begin
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
                        count <= 0;
                        done <= 1;
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
