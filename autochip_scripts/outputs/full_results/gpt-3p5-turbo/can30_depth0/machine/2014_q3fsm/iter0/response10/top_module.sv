module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

// Declare states
localparam [3:0] A = 4'b0001;
localparam [3:0] B = 4'b0010;
localparam [3:0] C = 4'b0111;
localparam [3:0] S10 = 4'b1010;
localparam [3:0] S11 = 4'b1011;
localparam [3:0] S20 = 4'b1101;
localparam [3:0] S21 = 4'b1110;
localparam [3:0] S22 = 4'b1111;

// Define current state register
reg [3:0] current_state;

// Define next state logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A;
    end else begin
        case (current_state)
            A: begin
                if (s) begin
                    current_state <= B;
                end
            end
            B: begin
                if (w) begin
                    current_state <= S11;
                end else begin
                    current_state <= S10;
                end
            end
            C: begin
                if (w) begin
                    current_state <= S11;
                end else begin
                    current_state <= S10;
                end
            end
            S10: begin
                if (w) begin
                    current_state <= S21;
                end else begin
                    current_state <= S20;
                end
            end
            S11: begin
                if (w) begin
                    current_state <= S22;
                end else begin
                    current_state <= S21;
                end
            end
            S20: begin
                current_state <= B;
            end
            S21: begin
                if (w) begin
                    current_state <= C;
                end else begin
                    current_state <= B;
                end
            end
            S22: begin
                if (w) begin
                    current_state <= B;
                end else begin
                    current_state <= C;
                end
            end
        endcase
    end
end

// Define output logic
always @(current_state) begin
    case (current_state)
        A: begin
            z <= 0;
        end
        B: begin
            z <= 0;
        end
        C: begin
            z <= 0;
        end
        S10: begin
            z <= 0;
        end
        S11: begin
            z <= 0;
        end
        S20: begin
            z <= 0;
        end
        S21: begin
            z <= 0;
        end
        S22: begin
            z <= 0;
        end
    endcase
end

endmodule
