module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;
localparam A = 4'b0000;
localparam B = 4'b0001;
localparam C = 4'b0010;
localparam S10 = 4'b0011;
localparam S11 = 4'b0100;
localparam S20 = 4'b0101;
localparam S21 = 4'b0110;
localparam S22 = 4'b0111;

always @(posedge clk or negedge reset) begin
    if(!reset) begin
        state <= A;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        A: begin
            if(s) begin
                next_state = B;
            end
            else begin
                next_state = A;
            end
        end
        B: begin
            if(w) begin
                next_state = S11;
            end
            else begin
                next_state = S10;
            end
        end
        C: begin
            if(w) begin
                next_state = S11;
            end
            else begin
                next_state = S10;
            end
        end
        S10: begin
            if(w) begin
                next_state = S21;
            end
            else begin
                next_state = S20;
            end
        end
        S11: begin
            if(w) begin
                next_state = S22;
            end
            else begin
                next_state = S21;
            end
        end
        S20: begin
            next_state = B;
        end
        S21: begin
            if(w) begin
                next_state = C;
            end
            else begin
                next_state = B;
            end
        end
        S22: begin
            if(w) begin
                next_state = B;
            end
            else begin
                next_state = C;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

always @(state) begin
    case(state)
        A: begin
            z = 0;
        end
        B: begin
            z = 0;
        end
        C: begin
            z = 0;
        end
        S10: begin
            z = 0;
        end
        S11: begin
            z = 0;
        end
        S20: begin
            z = 0;
        end
        S21: begin
            z = 0;
        end
        S22: begin
            z = 0;
        end
        default: begin
            z = 1;
        end
    endcase
end

endmodule
