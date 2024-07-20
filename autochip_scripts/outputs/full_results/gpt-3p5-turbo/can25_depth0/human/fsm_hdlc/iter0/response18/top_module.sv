module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);
    
    reg [2:0] state;
    reg [2:0] next_state;
    wire valid_flag;
    wire valid_disc;

    assign valid_disc = (state == 3'b011) ? 1'b1 : 1'b0;
    assign valid_flag = (state == 3'b010) ? 1'b1 : 1'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    always @(state, in) begin
        case (state)
            3'b000: begin
                if (in) begin
                    next_state = 3'b001;
                end else begin
                    next_state = 3'b000;
                end
            end
            3'b001: begin
                if (in) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b000;
                end
            end
            3'b010: begin
                if (in) begin
                    next_state = 3'b010;
                end else begin
                    next_state = 3'b011;
                end
            end
            3'b011: begin
                if (in) begin
                    next_state = 3'b100;
                end else begin
                    next_state = 3'b011;
                end
            end
            default: begin
                next_state = 3'b000;
            end
        endcase
    end

    assign disc = valid_disc;
    assign flag = valid_flag;
    assign err = (state == 3'b100) ? 1'b1 : 1'b0;

endmodule
