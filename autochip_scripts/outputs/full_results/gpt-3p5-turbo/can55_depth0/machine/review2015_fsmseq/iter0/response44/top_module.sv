module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [2:0] state;
reg [2:0] next_state;

parameter S = 3'b000;
parameter S1 = 3'b001;
parameter S11 = 3'b010;
parameter S110 = 3'b011;
parameter Done = 3'b100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        S: begin
            if (data) begin
                next_state = S1;
            end else begin
                next_state = S;
            end
        end
        
        S1: begin
            if (data) begin
                next_state = S11;
            end else begin
                next_state = S;
            end
        end
        
        S11: begin
            if (data) begin
                next_state = S11;
            end else begin
                next_state = S110;
            end
        end
        
        S110: begin
            if (data) begin
                next_state = Done;
            end else begin
                next_state = S;
            end
        end
        
        Done: begin
            next_state = Done;
        end
    end
end

always @(posedge clk) begin
    if (state == Done) begin
        start_shifting <= 1'b1;
    end else begin
        start_shifting <= 1'b0;
    end
end

endmodule
