module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end
        else begin
            state <= next_state;
        end
    end

    always @(state or in) begin
        case (state)
        
            3'b000: begin
                if (in) begin
                    next_state = 3'b001;
                end
                else begin
                    next_state = 3'b000;
                end
            end
        
            3'b001: begin
                if (in) begin
                    next_state = 3'b010;
                end
                else begin
                    next_state = 3'b000;
                end
            end
        
            3'b010: begin
                if (in) begin
                    next_state = 3'b011;
                end
                else begin
                    next_state = 3'b000;
                end
            end
        
            3'b011: begin
                if (in) begin
                    next_state = 3'b100;
                end
                else begin
                    next_state = 3'b000;
                end
                disc <= 1'b0;
                flag <= 1'b1;
                err <= 1'b0;
            end
        
            3'b100: begin
                if (in) begin
                    next_state = 3'b101;
                end
                else begin
                    next_state = 3'b001;
                end
            end
        
            3'b101: begin
                if (in) begin
                    next_state = 3'b110;
                end
                else begin
                    next_state = (in ? 3'b011 : 3'b101);
                end
                disc <= 1'b1;
                flag <= 1'b0;
                err <= 1'b0;
            end
        
            3'b110: begin
                if (in) begin
                    next_state = 3'b101;
                end
                else begin
                    next_state = 3'b100;
                end
            end
        
            3'b111: begin
                next_state <= 3'b000;
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b1;
            end
        
            default: begin
                next_state <= 3'b000;
                disc <= 1'b0;
                flag <= 1'b0;
                err <= 1'b0;
            end
        endcase
    end
endmodule
