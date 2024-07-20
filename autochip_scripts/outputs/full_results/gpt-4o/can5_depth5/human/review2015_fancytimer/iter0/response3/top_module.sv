module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State definitions
    localparam IDLE      = 3'b000;
    localparam PATTERN   = 3'b001;
    localparam LOAD_TIME = 3'b010;
    localparam COUNTING  = 3'b011;
    localparam DONE      = 3'b100;

    reg [2:0] state, next_state;
    reg [3:0] shift_reg;
    reg [3:0] delay_reg;
    reg [3:0] count_reg;
    reg [15:0] clock_count;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0;
            delay_reg <= 4'b0;
            count_reg <= 4'b0;
            clock_count <= 16'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    shift_reg <= 4'b0;
                    delay_reg <= 4'b0;
                    count_reg <= 4'b0;
                    clock_count <= 16'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                PATTERN: begin
                    shift_reg <= {shift_reg[2:0], data};
                end
                LOAD_TIME: begin
                    delay_reg <= {delay_reg[2:0], data};
                end
                COUNTING: begin
                    counting <= 1'b1;
                    if (clock_count == 16'd1000) begin
                        clock_count <= 16'b0;
                        if (count_reg == 4'b0) begin
                            next_state <= DONE;
                        end else begin
                            count_reg <= count_reg - 1;
                        end
                    end else begin
                        clock_count <= clock_count + 1;
                    end
                end
                DONE: begin
                    done <= 1'b1;
                    if (ack) begin
                        next_state <= IDLE;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101) begin
                    next_state = PATTERN;
                end
            end
            PATTERN: begin
                if (shift_reg == 4'b1101) begin
                    next_state = LOAD_TIME;
                end
            end
            LOAD_TIME: begin
                if (&delay_reg) begin  // all bits have been shifted in
                    next_state = COUNTING;
                    count_reg = delay_reg;
                    clock_count = 16'b0;
                end
            end
            COUNTING: begin
                if (clock_count == 1000 * (delay_reg + 1)) begin
                    next_state = DONE;
                end
            end
            DONE: begin
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    assign count = count_reg;

endmodule
