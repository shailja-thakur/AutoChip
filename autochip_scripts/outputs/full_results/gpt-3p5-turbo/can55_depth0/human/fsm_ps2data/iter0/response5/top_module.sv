module datapath (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
    reg [1:0] state_reg;
    reg [23:0] data_reg;
    wire is_byte_1;
    
    always @(posedge clk) begin
        if (reset) begin
            state_reg <= 0;
            data_reg <= 0;
            done <= 0;
        end else begin
            case (state_reg)
                0: begin  // Wait for in[3] == 1
                    if (in[3]) begin
                        state_reg <= 1;
                    end
                end
                1: begin  // Receive byte 1
                    data_reg[23:16] <= in;
                    state_reg <= 2;
                end
                2: begin  // Receive byte 2
                    data_reg[15:8] <= in;
                    state_reg <= 3;
                end
                3: begin  // Receive byte 3
                    data_reg[7:0] <= in;
                    state_reg <= 0;
                    done <= 1;
                end
                default: state_reg <= 0;
            endcase
        end
    end
    
    assign out_bytes = data_reg;
    assign is_byte_1 = (state_reg == 1);
    
endmodule
module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

    wire is_byte_1;
    wire [23:0] data;
    
    datapath datapath_inst (
        .clk(clk),
        .in(in),
        .reset(reset),
        .out_bytes(data),
        .done(done),
    );
    
    assign out_bytes = data;
endmodule
