module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg done
);

    // Registers for FSM state and current byte count
    reg [1:0] state;
    reg [2:0] count;
    reg [7:0] input_reg;

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
        end else begin
            case (state)
                IDLE: begin
                    if (in[3] == 1'b1) begin
                        state <= SEARCH;
                        count <= 1;
                        input_reg <= in;
                    end
                end
                SEARCH: begin
                    if (count == 2) begin
                        if (in[3] == 1'b1) begin
                            state <= SEARCH;
                            count <= count + 1;
                            input_reg <= {input_reg[6:0], in};
                        end else begin
                            state <= IDLE;
                            count <= 0;
                            done <= 0;
                        end
                    end else begin
                        state <= SEARCH;
                        count <= count + 1;
                        input_reg <= {input_reg[6:0], in};
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

    // Check for message completion
    always @(posedge clk) begin
        if (state == SEARCH && count == 2 && input_reg[3] == 1'b1) begin
            state <= DONE;
            count <= 0;
            done <= 1;
        end
    end

endmodule
